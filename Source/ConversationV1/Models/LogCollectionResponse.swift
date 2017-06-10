/**
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import RestKit

/** LogCollectionResponse. */
public struct LogCollectionResponse: JSONDecodable, JSONEncodable {

    /// An array of log events.
    public let logs: [LogExportResponse]

    /// An object defining the pagination data for the returned objects.
    public let pagination: LogPaginationResponse

    /**
     Initialize a `LogCollectionResponse` with member variables.

     - parameter logs: An array of log events.
     - parameter pagination: An object defining the pagination data for the returned objects.

     - returns: An initialized `LogCollectionResponse`.
    */
    public init(logs: [LogExportResponse], pagination: LogPaginationResponse) {
        self.logs = logs
        self.pagination = pagination
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `LogCollectionResponse` model from JSON.
    public init(json: JSON) throws {
        logs = try json.decodedArray(at: "logs", type: LogExportResponse.self)
        pagination = try json.decode(at: "pagination", type: LogPaginationResponse.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `LogCollectionResponse` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["logs"] = logs.map { $0.toJSONObject() }
        json["pagination"] = pagination.toJSONObject()
        return json
    }
}
