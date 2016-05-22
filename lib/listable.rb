module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(start_date, end_date = nil)
    if start_date && end_date
      "#{start_date.strftime("%D")} -- #{end_date.strftime("%D")}"
    elsif start_date
      "#{start_date.strftime("%D")}"
    else
      "N/A"
    end
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end
end
