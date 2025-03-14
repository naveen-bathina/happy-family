using HappyFamily.Common.DTOs;
using HappyFamily.Data.Mongo;
using HappyFamily.Data.Mongo.Entities;
using HappyFamily.Services.Abstractions;
using MongoDB.Bson;
using MongoDB.Driver;

namespace HappyFamily.Services.Implementation
{
    public class FamilyService : IFamilyService
    {

        private readonly MongoDBContext _mongoDBContext;

        public FamilyService(MongoDBContext mongoDBContext)
        {
            _mongoDBContext = mongoDBContext;
        }

        public FamilyInfoDto GetFamilyDetailById(string id)
        {
            id = "67c419fe323966284b921e9a";

            var fam = _mongoDBContext.Families.Find(x => x.Id == ObjectId.Parse(id)).FirstOrDefault();

            var familyInfo = new FamilyInfoDto()
            {
                Id = "happyfamily1",
                FamilyName = "Bathina",
                FamilyDisplayPictureUrl = "https://cdn.dribbble.com/users/3988742/screenshots/7149635/media/fb27d5eb2b07aa6db3cdae31e6562561.jpg",
                Members = new List<FamilyMemberDto>()
                {
                    new FamilyMemberDto(){
                        FirstName = "Murali Krishna",
                        LastName="Bathina",
                        EmailAddress="murali.bathina9@gmail.com",
                        ContactNumber="+91 889 746 8169",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Father",
                        Role="Head of the Family",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                    new FamilyMemberDto() {
                        FirstName = "Revathi",
                        LastName="Bathina",
                        EmailAddress="revathi.bathina@happyfamily.com",
                        ContactNumber="+91 898 558 1306",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Wife",
                        Role="Family Member",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                    new FamilyMemberDto() {
                        FirstName = "Sudha Rani",
                        LastName="Bathina",
                        EmailAddress="sudha.rani@happyfamily.com",
                        ContactNumber="+91 898 558 1306",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Daughter",
                        Role="Family Member",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                    new FamilyMemberDto() {
                        FirstName = "Naveen",
                        LastName="Bathina",
                        EmailAddress="naveen.bathina@happyfamily.com",
                        ContactNumber="+91 953 807 6717",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Son",
                        Role="Family Member",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                    new FamilyMemberDto() {
                        FirstName = "Jahnavi",
                        LastName="Baditala",
                        EmailAddress="jahnavi.baditala@happyfamily.com",
                        ContactNumber="+91 898 558 1306",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Grand Daughter",
                        Role="Family Member",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                    new FamilyMemberDto() {
                        FirstName = "Purna Sai",
                        LastName="Baditala",
                        EmailAddress="purna.sai@happyfamily.com",
                        ContactNumber="+91 898 558 1306",
                        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
                        Relation="Grand Son",
                        Role="Family Member",
                        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
                    },
                }
            };

            // _mongoDBContext.Families.InsertOne(new Family()
            // {
            //     FamilyName = "Bathina",
            //     FamilyDisplayPictureUrl = "https://cdn.dribbble.com/users/3988742/screenshots/7149635/media/fb27d5eb2b07aa6db3cdae31e6562561.jpg",
            //     Members = new List<FamilyMember>()
            //     {
            //         new FamilyMember(){
            //             FirstName = "Murali Krishna",
            //             LastName="Bathina",
            //             EmailAddress="murali.bathina9@gmail.com",
            //             ContactNumber="+91 889 746 8169",
            //             DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
            //             Relation="Father",
            //             Role="Head of the Family",
            //             Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
            //         },
            //     }
            // });


            return familyInfo;
        }
    }
}
