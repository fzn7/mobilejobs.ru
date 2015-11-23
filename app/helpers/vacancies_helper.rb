module VacanciesHelper
  def company_location_tag(vacancy)
    [vacancy.company, vacancy.location].reject{ |i| i.blank? }.join(" - ")
  end

  def isEmail(str)
    return str.match(/@/)
  end
end
