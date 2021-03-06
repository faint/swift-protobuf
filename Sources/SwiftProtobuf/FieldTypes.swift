// Sources/SwiftProtobuf/FieldTypes.swift - Proto data types
//
// Copyright (c) 2014 - 2016 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/master/LICENSE.txt
//
// -----------------------------------------------------------------------------
///
/// Serialization/deserialization support for each proto field type.
///
/// Note that we cannot just extend the standard Int32, etc, types
/// with serialization information since proto language supports
/// distinct types (with different codings) that use the same
/// in-memory representation.  For example, proto "sint32" and
/// "sfixed32" both are represented in-memory as Int32.
///
/// These types are used generically and also passed into
/// various coding/decoding functions to provide type-specific
/// information.
///
// -----------------------------------------------------------------------------

import Foundation

// Note: The protobuf- and JSON-specific methods here are defined
// in ProtobufTypeAdditions.swift and JSONTypeAdditions.swift
public protocol FieldType {
    // The Swift type used to store data for this field.
    // For example, proto "sint32" fields use Swift "Int32"
    // type.
    associatedtype BaseType: Hashable

    // The default value for this field type before it
    // has been set.  This is also used, for example, when
    // JSON decodes a "null" value for a field.
    static var proto3DefaultValue: BaseType { get }

    // Generic reflector methods for looking up the correct decoding
    // for extension fields, map keys, and map values.
    static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws
    static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws

    // The protobuf wire format used for this type.
    static var protobufWireFormat: WireFormat { get }

    /// Returns the number of bytes required to serialize `value` on the wire.
    ///
    /// Note that for length-delimited data (such as strings, bytes, and messages), the returned
    /// size includes the space required for the length prefix. For messages, this is a subtle
    /// distinction from the `serializedSize()` method, which does *not* include the length prefix.
    static func encodedSizeWithoutTag(of value: BaseType) throws -> Int

    /// Write the protobuf-encoded value to the encoder
    static func serializeProtobufValue(encoder: inout BinaryEncoder, value: BaseType)

    /// Serialize the value to a Text encoder
    static func serializeTextValue(encoder: TextFormatEncoder, value: BaseType) throws

    /// Serialize the value to a JSON encoder
    static func serializeJSONValue(encoder: inout JSONEncoder, value: BaseType) throws
}

///
/// Protocol for types that can be used as map keys
///
public protocol MapKeyType: FieldType {
    associatedtype BaseType: Hashable = Self

    //
    // Protobuf binary does not treat map keys specially
    //

    //
    // Protobuf Text does not treat map keys specially
    //

    //
    // JSON encoding for map keys: JSON requires map keys
    // to be quoted, so needs special handling.
    //
    static func serializeJSONMapKey(encoder: inout JSONEncoder, value: BaseType)
}

///
/// Marker Protocol for types that can be used as map values.
///
public protocol MapValueType: FieldType {
}

//
// We have a struct for every basic proto field type which provides
// serialization/deserialization support as static methods.
//

///
/// Float traits
///
public struct ProtobufFloat: FieldType, MapValueType {
    public typealias BaseType = Float
    static public var proto3DefaultValue: Float {return 0.0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFloatField(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFloatField(value: &value)
    }
}

///
/// Double
///
public struct ProtobufDouble: FieldType, MapValueType {
    public typealias BaseType = Double
    static public var proto3DefaultValue: Double {return 0.0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularDoubleField(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedDoubleField(value: &value)
    }
}

///
/// Int32
///
public struct ProtobufInt32: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int32
    static public var proto3DefaultValue: Int32 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularInt32Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedInt32Field(value: &value)
    }
}

///
/// Int64
///

public struct ProtobufInt64: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int64
    static public var proto3DefaultValue: Int64 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularInt64Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedInt64Field(value: &value)
    }
}

///
/// UInt32
///
public struct ProtobufUInt32: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = UInt32
    static public var proto3DefaultValue: UInt32 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularUInt32Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedUInt32Field(value: &value)
    }
}

///
/// UInt64
///

public struct ProtobufUInt64: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = UInt64
    static public var proto3DefaultValue: UInt64 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularUInt64Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedUInt64Field(value: &value)
    }
}

///
/// SInt32
///
public struct ProtobufSInt32: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int32
    static public var proto3DefaultValue: Int32 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSInt32Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSInt32Field(value: &value)
    }
}

///
/// SInt64
///

public struct ProtobufSInt64: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int64
    static public var proto3DefaultValue: Int64 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSInt64Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSInt64Field(value: &value)
    }
}

///
/// Fixed32
///
public struct ProtobufFixed32: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = UInt32
    static public var proto3DefaultValue: UInt32 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFixed32Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFixed32Field(value: &value)
    }
}

///
/// Fixed64
///
public struct ProtobufFixed64: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = UInt64
    static public var proto3DefaultValue: UInt64 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularFixed64Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedFixed64Field(value: &value)
    }
}

///
/// SFixed32
///
public struct ProtobufSFixed32: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int32
    static public var proto3DefaultValue: Int32 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSFixed32Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSFixed32Field(value: &value)
    }
}

///
/// SFixed64
///
public struct ProtobufSFixed64: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Int64
    static public var proto3DefaultValue: Int64 {return 0}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularSFixed64Field(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedSFixed64Field(value: &value)
    }
}

///
/// Bool
///
public struct ProtobufBool: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = Bool
    static public var proto3DefaultValue: Bool {return false}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularBoolField(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedBoolField(value: &value)
    }
}

///
/// String
///
public struct ProtobufString: FieldType, MapKeyType, MapValueType {
    public typealias BaseType = String
    static public var proto3DefaultValue: String {return ""}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularStringField(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedStringField(value: &value)
    }
}

///
/// Bytes
///
public struct ProtobufBytes: FieldType, MapValueType {
    public typealias BaseType = Data
    static public var proto3DefaultValue: Data {return Data()}
    public static func decodeSingular<D: Decoder>(value: inout BaseType?, from decoder: inout D) throws {
        try decoder.decodeSingularBytesField(value: &value)
    }
    public static func decodeRepeated<D: Decoder>(value: inout [BaseType], from decoder: inout D) throws {
        try decoder.decodeRepeatedBytesField(value: &value)
    }
}
