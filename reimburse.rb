puts "hello world"
require 'date'

SET_1 = [
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-03")
  }
]

SET_2 = [
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-01")
  },
  {
    city_cost: :high, 
    start_date: Date.parse("2015-09-02"),
    end_date: Date.parse("2015-09-06")
  },
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-06"),
    end_date: Date.parse("2015-09-08")
  }
]

SET_3 = [
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-03")
  },
  {
    city_cost: :high, 
    start_date: Date.parse("2015-09-05"),
    end_date: Date.parse("2015-09-07")
  },
  {
    city_cost: :high, 
    start_date: Date.parse("2015-09-08"),
    end_date: Date.parse("2015-09-08")
  }
]

SET_4 = [
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-01")
  },
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-01")
  },
  {
    city_cost: :high, 
    start_date: Date.parse("2015-09-02"),
    end_date: Date.parse("2015-09-02")
  },
  {
    city_cost: :high, 
    start_date: Date.parse("2015-09-02"),
    end_date: Date.parse("2015-09-03")
  }
]

TRAVEL_COST_LOW = 45
TRAVEL_COST_HIGH = 55
FULL_COST_LOW = 75
FULL_COST_HIGH = 85


class Reimburser  
  
  def calculate(projects) 
    set_start_date = projects.map{|p| p[:start_date]}.min
    set_end_date = projects.map{|p| p[:end_date]}.max
    set_range = (set_start_date..set_end_date)
    reimbursement_hash = {}
    reimbursement = 0
    set_range.each_with_index do |date, i|
      # puts date
      active_projects = projects.select{|p| date.between? p[:start_date], p[:end_date]}
      active_projects_yesterday = projects.select{|p| (date-1).between? p[:start_date], p[:end_date]}
      active_projects_tomorrow = projects.select{|p| (date+1).between? p[:start_date], p[:end_date]}
      # puts active_projects
      city_cost = active_projects.map{|p| p[:city_cost]}.include? :high ? :high : :low
      
      # If two projects push up against each other, or overlap, then those days are full days as well.
      # Any given day is only ever counted once, even if two projects are on the same day.
      if active_projects.length > 1
        reimbursement += city_cost == :high ? FULL_COST_HIGH : FULL_COST_LOW
      # First day and last day of a project, or sequence of projects, is a travel day.
      # If there is a gap between projects, then the days on either side of that gap are travel days.
      elsif active_projects_yesterday.none? || active_projects_tomorrow.none?
        reimbursement += city_cost == :high ? TRAVEL_COST_HIGH : TRAVEL_COST_LOW
      # Any day in the middle of a project, or sequence of projects, is considered a full day.
      else
        reimbursement += city_cost == :high ? FULL_COST_HIGH : FULL_COST_LOW
      end
    end
    return reimbursement
  end
end

puts Reimburser.new.calculate(SET_1)
puts Reimburser.new.calculate(SET_2)
puts Reimburser.new.calculate(SET_3)
puts Reimburser.new.calculate(SET_4)