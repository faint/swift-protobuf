// Sources/SwiftProtobuf/TextFormatEncodingVisitor.swift - Text format encoding support
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/master/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Text format serialization engine.
///
// -----------------------------------------------------------------------------

import Foundation

/// Visitor that serializes a message into protobuf text format.
final class TextFormatEncodingVisitor: Visitor {

  private var encoder: TextFormatEncoder
  private var inExtension = false
  private var nameResolver: (Int) -> String?

  /// The protobuf text produced by the visitor.
  var result: String {
    return encoder.result
  }

  /// Creates a new visitor that serializes the given message to protobuf text
  /// format.
  convenience init(message: Message) {
    self.init(message: message, encoder: TextFormatEncoder())
  }

  /// Creates a new visitor that serializes the given message to protobuf text
  /// format, using an existing encoder.
  init(message: Message, encoder: TextFormatEncoder) {
    self.encoder = encoder
    self.nameResolver = ProtoNameResolvers.protoFieldNameResolver(for: message)
  }

  func visitUnknown(bytes: Data) {
    // TODO: Print unknown fields by tag number.
  }

  func visitSingularField<S: FieldType>(fieldType: S.Type,
                                        value: S.BaseType,
                                        fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    encoder.startField(name: protoFieldName)
    try S.serializeTextValue(encoder: encoder, value: value)
    encoder.endField()
  }

  func visitRepeatedField<S: FieldType>(fieldType: S.Type,
                                        value: [S.BaseType],
                                        fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    for v in value {
      encoder.startField(name: protoFieldName)
      try S.serializeTextValue(encoder: encoder, value: v)
      encoder.endField()
    }
  }

  func visitPackedField<S: FieldType>(fieldType: S.Type,
                                      value: [S.BaseType],
                                      fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    encoder.startField(name: protoFieldName)
    var firstItem = true
    encoder.startArray()
    for v in value {
      if !firstItem {
        encoder.arraySeparator()
      }
      try S.serializeTextValue(encoder: encoder, value: v)
      firstItem = false
    }
    encoder.endArray()
    encoder.endField()
  }

  func visitSingularEnumField<E: Enum>(value: E, fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    encoder.startField(name: protoFieldName)
    encoder.putEnumValue(value: value)
    encoder.endField()
  }

  func visitRepeatedEnumField<E: Enum>(value: [E], fieldNumber: Int) throws {
      let protoFieldName = try self.protoFieldName(for: fieldNumber)
      for v in value {
          encoder.startField(name: protoFieldName)
          encoder.putEnumValue(value: v)
          encoder.endField()
      }
  }

  func visitPackedEnumField<E: Enum>(value: [E], fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    encoder.startField(name: protoFieldName)
    var firstItem = true
    encoder.startArray()
    for v in value {
      if !firstItem {
        encoder.arraySeparator()
      }
      encoder.putEnumValue(value: v)
      firstItem = false
    }
    encoder.endArray()
    encoder.endField()
  }

  func visitSingularMessageField<M: Message>(value: M,
                                             fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    encoder.startMessageField(name: protoFieldName)
    encoder.startObject()
    let visitor = TextFormatEncodingVisitor(message: value, encoder: encoder)
    try value.traverse(visitor: visitor)
    encoder.endObject()
    encoder.endField()
  }

  func visitRepeatedMessageField<M: Message>(value: [M],
                                             fieldNumber: Int) throws {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    for v in value {
      encoder.startMessageField(name: protoFieldName)
      encoder.startObject()
      let visitor = TextFormatEncodingVisitor(message: v, encoder: encoder)
      try v.traverse(visitor: visitor)
      encoder.endObject()
      encoder.endField()
    }
  }

  func visitMapField<KeyType: MapKeyType, ValueType: MapValueType>(
    fieldType: ProtobufMap<KeyType, ValueType>.Type,
    value: ProtobufMap<KeyType, ValueType>.BaseType,
    fieldNumber: Int
  ) throws where KeyType.BaseType: Hashable {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    for (k,v) in value {
      encoder.startMessageField(name: protoFieldName)
      encoder.startObject()
      encoder.startField(name: "key")
      try KeyType.serializeTextValue(encoder: encoder, value: k)
      encoder.endField()
      encoder.startField(name: "value")
      try ValueType.serializeTextValue(encoder: encoder, value: v)
      encoder.endField()
      encoder.endObject()
      encoder.endField()
    }
  }

  func visitMapField<KeyType: MapKeyType, ValueType: Enum>(
    fieldType: ProtobufEnumMap<KeyType, ValueType>.Type,
    value: ProtobufEnumMap<KeyType, ValueType>.BaseType,
    fieldNumber: Int
  ) throws where KeyType.BaseType: Hashable, ValueType.RawValue == Int {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    for (k,v) in value {
      encoder.startMessageField(name: protoFieldName)
      encoder.startObject()
      encoder.startField(name: "key")
      try KeyType.serializeTextValue(encoder: encoder, value: k)
      encoder.endField()
      encoder.startField(name: "value")
      encoder.putEnumValue(value: v)
      encoder.endField()
      encoder.endObject()
      encoder.endField()
    }
  }

  func visitMapField<KeyType: MapKeyType, ValueType: Message>(
    fieldType: ProtobufMessageMap<KeyType, ValueType>.Type,
    value: ProtobufMessageMap<KeyType, ValueType>.BaseType,
    fieldNumber: Int
  ) throws where KeyType.BaseType: Hashable {
    let protoFieldName = try self.protoFieldName(for: fieldNumber)
    for (k,v) in value {
      encoder.startMessageField(name: protoFieldName)
      encoder.startObject()
      encoder.startField(name: "key")
      try KeyType.serializeTextValue(encoder: encoder, value: k)
      encoder.endField()
      encoder.startField(name: "value")
      encoder.startObject()
      let visitor = TextFormatEncodingVisitor(message: v, encoder: encoder)
      try v.traverse(visitor: visitor)
      encoder.endObject()
      encoder.endField()
      encoder.endObject()
      encoder.endField()
    }
  }

  /// Called for each extension range.
  func visitExtensionFields(fields: ExtensionFieldValueSet, start: Int, end: Int) throws {
    inExtension = true
    try fields.traverse(visitor: self, start: start, end: end)
    inExtension = false
  }

  /// Helper function that throws an error if the field number could not be
  /// resolved.
  private func protoFieldName(for number: Int) throws -> String {
    if let protoName = nameResolver(number) {
      if inExtension {
        return "[\(protoName)]"
      } else {
        return protoName
      }
    }
    throw EncodingError.missingFieldNames
  }
}
