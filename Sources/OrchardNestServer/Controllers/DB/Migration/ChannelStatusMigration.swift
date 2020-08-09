import Fluent
import Vapor

struct ChannelStatusMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    var channelStatusType = database.enum("channel_status_type")
    for type in ChannelStatusType.allCases {
      channelStatusType = channelStatusType.case(type.rawValue)
    }
    return channelStatusType.create().flatMap { channelStatusType in

      database.schema(ChannelStatus.schema)
        .field("feed_url", .string, .identifier(auto: false))
        .field("status", channelStatusType, .required)
        .create()
    }
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(ChannelStatus.schema).delete()
  }
}
