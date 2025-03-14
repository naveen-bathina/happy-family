﻿using HappyFamily.Common.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyFamily.Services.Abstractions
{
    public interface IToDoService
    {
        IEnumerable<ToDoDto> GetAll();
    }
}
