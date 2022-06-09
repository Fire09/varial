
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "varial-apartments:handler", key = { forclose = true} },
          { title = "No", action = "varial-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
