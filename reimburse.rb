require 'date'

SET_1 = [
  {
    city_cost: :low, 
    start_date: Date.parse("2015-09-01"),
    end_date: Date.parse("2015-09-03")
  }
]
# Day1: 45, Day2: 75, Day3: 45 = 165

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
# Day1: 45, Day2: 85, Day3: 85, Day4: 85, Day5: 85, Day6: 85, Day7: 75, Day8: 45 = 590

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
# Day1: 45, Day2: 75, Day3: 45, Day4: 0, Day5: 55, Day6: 85, Day7: 85, Day8: 55 = 445

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
# Day1: 45, Day2: 85, Day3: 55 = 185

TRAVEL_COST_LOW = 45
TRAVEL_COST_HIGH = 55
FULL_COST_LOW = 75
FULL_COST_HIGH = 85

class Reimburser  
  def calculate(projects) 
    set_start_date = projects.map{|p| p[:start_date]}.min
    set_end_date = projects.map{|p| p[:end_date]}.max
    set_range = (set_start_date..set_end_date)
    reimbursement = 0
    set_range.each_with_index do |date, i|
      active_projects = projects.select{|p| date.between? p[:start_date], p[:end_date]}
      active_projects_yesterday = projects.select{|p| (date-1).between? p[:start_date], p[:end_date]}
      active_projects_tomorrow = projects.select{|p| (date+1).between? p[:start_date], p[:end_date]}

      city_cost = active_projects.map{|p| p[:city_cost]}.include?(:high) ? :high : :low
      
      # First day and last day of a project, or sequence of projects, is a travel day.
      # If there is a gap between projects, then the days on either side of that gap are travel days.
      if active_projects.any? && (active_projects_yesterday.none? || active_projects_tomorrow.none?)
        reimbursement += city_cost == :high ? TRAVEL_COST_HIGH : TRAVEL_COST_LOW
      # If two projects push up against each other, or overlap, then those days are full days as well.
      # Any given day is only ever counted once, even if two projects are on the same day.
      elsif active_projects.length > 1
        reimbursement += city_cost == :high ? FULL_COST_HIGH : FULL_COST_LOW
      # Any day in the middle of a project, or sequence of projects, is considered a full day.
      elsif active_projects.any?
        reimbursement += city_cost == :high ? FULL_COST_HIGH : FULL_COST_LOW
      end
    end
    return reimbursement
  end
end

puts "Set 1 reimbursement: #{Reimburser.new.calculate(SET_1)}"
puts "Set 2 reimbursement: #{Reimburser.new.calculate(SET_2)}"
puts "Set 3 reimbursement: #{Reimburser.new.calculate(SET_3)}"
puts "Set 4 reimbursement: #{Reimburser.new.calculate(SET_4)}"