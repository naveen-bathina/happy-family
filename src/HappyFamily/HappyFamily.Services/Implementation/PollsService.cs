using HappyFamily.Common.DTOs;
using HappyFamily.Services.Abstractions;

namespace HappyFamily.Services.Implementation
{
    public class PollsService : IPollsService
    {
        public IEnumerable<PollDto> GetPolls()
        {
            return SeedDummyData();
        }


        private List<PollDto> SeedDummyData()
        {
            return new List<PollDto>() {
                new(){
                    Id = "poll1",
                    Title = "Choose your best operating system ?",
                    Description = "Operating system selection",
                    expiryDate = DateTime.Today.AddDays(2),
                    Options = new(){
                        new PollOption() { Id = "poll1-option1", Title ="Windows", Votes = 3},
                        new PollOption() { Id = "poll1-option2", Title ="Linux", Votes = 5},
                        new PollOption() { Id = "poll1-option3", Title ="Mac", Votes = 8},
                        new PollOption() { Id = "poll1-option4", Title ="Chrome", Votes = 10},
                    }
                },
                new(){
                    Id = "poll2",
                    Title = "Do you agree to insure our family members ?",
                    Description = "Insurance purchase",
                    expiryDate = DateTime.Today.AddDays(2),
                    Options = new(){
                        new PollOption() { Id = "poll2-option1", Title ="Yes", Votes = 7},
                        new PollOption() { Id = "poll2-option2", Title ="No", Votes = 3},
                    }
                }
            };
        }
    }
}
