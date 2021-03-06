/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: unittest_swift_enum.proto
 *
 */

//  Protocol Buffers - Google's data interchange format
//  Copyright 2015 Apple, Inc.  All Rights Reserved.
//  https://developers.google.com/protocol-buffers/
// 
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are
//  met:
// 
//      * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//      * Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following disclaimer
//  in the documentation and/or other materials provided with the
//  distribution.
//      * Neither the name of Google Inc. nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
// 
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _1: SwiftProtobuf.ProtobufAPIVersion_1 {}
  typealias Version = _1
}

struct ProtobufUnittest_SwiftEnumTest: SwiftProtobuf.Message, SwiftProtobuf.Proto2Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf.ProtoNameProviding {
  static let protoMessageName: String = "SwiftEnumTest"
  static let protoPackageName: String = "protobuf_unittest"
  static let _protobuf_fieldNames = FieldNameMap()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum EnumTest1: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case firstValue // = 1
    case secondValue // = 2

    init() {
      self = .firstValue
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 1: self = .firstValue
      case 2: self = .secondValue
      default: return nil
      }
    }

    init?(jsonName: String) {
      switch jsonName {
      case "ENUM_TEST_1_FIRST_VALUE": self = .firstValue
      case "ENUM_TEST_1_SECOND_VALUE": self = .secondValue
      default: return nil
      }
    }

    init?(protoName: String) {
      switch protoName {
      case "ENUM_TEST_1_FIRST_VALUE": self = .firstValue
      case "ENUM_TEST_1_SECOND_VALUE": self = .secondValue
      default: return nil
      }
    }

    var rawValue: Int {
      get {
        switch self {
        case .firstValue: return 1
        case .secondValue: return 2
        }
      }
    }

    var _protobuf_jsonName: String? {
      get {
        switch self {
        case .firstValue: return "ENUM_TEST_1_FIRST_VALUE"
        case .secondValue: return "ENUM_TEST_1_SECOND_VALUE"
        }
      }
    }

  }

  enum EnumTest2: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case enumTest2FirstValue // = 1
    case secondValue // = 2

    init() {
      self = .enumTest2FirstValue
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 1: self = .enumTest2FirstValue
      case 2: self = .secondValue
      default: return nil
      }
    }

    init?(jsonName: String) {
      switch jsonName {
      case "ENUM_TEST_2_FIRST_VALUE": self = .enumTest2FirstValue
      case "SECOND_VALUE": self = .secondValue
      default: return nil
      }
    }

    init?(protoName: String) {
      switch protoName {
      case "ENUM_TEST_2_FIRST_VALUE": self = .enumTest2FirstValue
      case "SECOND_VALUE": self = .secondValue
      default: return nil
      }
    }

    var rawValue: Int {
      get {
        switch self {
        case .enumTest2FirstValue: return 1
        case .secondValue: return 2
        }
      }
    }

    var _protobuf_jsonName: String? {
      get {
        switch self {
        case .enumTest2FirstValue: return "ENUM_TEST_2_FIRST_VALUE"
        case .secondValue: return "SECOND_VALUE"
        }
      }
    }

  }

  enum EnumTestNoStem: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case enumTestNoStem1 // = 1
    case enumTestNoStem2 // = 2

    init() {
      self = .enumTestNoStem1
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 1: self = .enumTestNoStem1
      case 2: self = .enumTestNoStem2
      default: return nil
      }
    }

    init?(jsonName: String) {
      switch jsonName {
      case "ENUM_TEST_NO_STEM_1": self = .enumTestNoStem1
      case "ENUM_TEST_NO_STEM_2": self = .enumTestNoStem2
      default: return nil
      }
    }

    init?(protoName: String) {
      switch protoName {
      case "ENUM_TEST_NO_STEM_1": self = .enumTestNoStem1
      case "ENUM_TEST_NO_STEM_2": self = .enumTestNoStem2
      default: return nil
      }
    }

    var rawValue: Int {
      get {
        switch self {
        case .enumTestNoStem1: return 1
        case .enumTestNoStem2: return 2
        }
      }
    }

    var _protobuf_jsonName: String? {
      get {
        switch self {
        case .enumTestNoStem1: return "ENUM_TEST_NO_STEM_1"
        case .enumTestNoStem2: return "ENUM_TEST_NO_STEM_2"
        }
      }
    }

  }

  enum EnumTestReservedWord: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case `var` // = 1
    case notReserved // = 2

    init() {
      self = .`var`
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 1: self = .`var`
      case 2: self = .notReserved
      default: return nil
      }
    }

    init?(jsonName: String) {
      switch jsonName {
      case "ENUM_TEST_RESERVED_WORD_VAR": self = .`var`
      case "ENUM_TEST_RESERVED_WORD_NOT_RESERVED": self = .notReserved
      default: return nil
      }
    }

    init?(protoName: String) {
      switch protoName {
      case "ENUM_TEST_RESERVED_WORD_VAR": self = .`var`
      case "ENUM_TEST_RESERVED_WORD_NOT_RESERVED": self = .notReserved
      default: return nil
      }
    }

    var rawValue: Int {
      get {
        switch self {
        case .`var`: return 1
        case .notReserved: return 2
        }
      }
    }

    var _protobuf_jsonName: String? {
      get {
        switch self {
        case .`var`: return "ENUM_TEST_RESERVED_WORD_VAR"
        case .notReserved: return "ENUM_TEST_RESERVED_WORD_NOT_RESERVED"
        }
      }
    }

  }

  mutating func _protoc_generated_decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      try decodeField(decoder: &decoder, fieldNumber: fieldNumber)
    }
  }

  mutating func _protoc_generated_decodeField<D: SwiftProtobuf.Decoder>(decoder: inout D, fieldNumber: Int) throws {
  }

  func _protoc_generated_traverse(visitor: SwiftProtobuf.Visitor) throws {
    unknownFields.traverse(visitor: visitor)
  }

  func _protoc_generated_isEqualTo(other: ProtobufUnittest_SwiftEnumTest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
