import SwiftUI

public struct CodableUIImage: Codable {
  public let image: UIImage

  public enum CodingKeys: String, CodingKey {
    case image
  }

  public init(image: UIImage) {
    self.image = image
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let data = try container.decode(Data.self, forKey: CodingKeys.image)
    guard let image = UIImage(data: data) else {
        throw EncodingError.CannotGetAnImage
    }

    self.image = image
  }
    
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    guard let data = image.pngData() else {
        return
    }

    try container.encode(data, forKey: CodingKeys.image)
  }
}

enum EncodingError: Error {
    case CannotGetAnImage
}
