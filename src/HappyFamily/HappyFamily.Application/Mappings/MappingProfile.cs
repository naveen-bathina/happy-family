using AutoMapper;
using HappyFamily.Domain.Entities;
using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<About, AboutDto>().ReverseMap();
            CreateMap<AboutRequest, About>().ReverseMap();
            CreateMap<Document, DocumentDto>().ReverseMap();
            CreateMap<Event, EventDto>().ReverseMap();
            CreateMap<Family, FamilyDto>().ReverseMap();
            CreateMap<FamilyMember, FamilyMemberDto>().ReverseMap();
            CreateMap<Notification, NotificationDto>().ReverseMap();
            CreateMap<Poll, PollDto>().ReverseMap();
            CreateMap<Reminder, ReminderDto>().ReverseMap();
            CreateMap<ToDo, ToDoDto>().ReverseMap();
            CreateMap<SupportTicket, SuppportTicketDto>().ReverseMap();
            CreateMap<Chat, ChatDto>().ReverseMap();
            CreateMap<ChatMessage, ChatMessageDto>().ReverseMap();
            CreateMap<UserProfile, UserProfileDto>().ReverseMap();
        }
    }
}
