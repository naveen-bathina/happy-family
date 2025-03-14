
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace HappyFamily.Data.Mongo.Entities;

public abstract class EntityBase
{
    [BsonId]
    public ObjectId Id { get; set; } = ObjectId.GenerateNewId();
}


public class MemberProfile : EntityBase
{
    public string Name { get; set; }
    public string Description { get; set; }
    public string ProfilePictureUrl { get; set; }
}