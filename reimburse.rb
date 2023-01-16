puts "hello world"
require 'date'

SET_1 = [
  {
    city_cost: :low, 
    start_date: "2015-09-01",
    end_date: "2015-09-03"
  }
]

SET_2 = [
  {
    city_cost: :low, 
    start_date: "2015-09-01",
    end_date: "2015-09-01"
  },
  {
    city_cost: :high, 
    start_date: "2015-09-02",
    end_date: "2015-09-06"
  },
  {
    city_cost: :low, 
    start_date: "2015-09-06",
    end_date: "2015-09-08"
  }
]

SET_3 = [
  {
    city_cost: :low, 
    start_date: "2015-09-01",
    end_date: "2015-09-03"
  },
  {
    city_cost: :high, 
    start_date: "2015-09-05",
    end_date: "2015-09-07"
  },
  {
    city_cost: :high, 
    start_date: "2015-09-08",
    end_date: "2015-09-08"
  }
]

SET_4 = [
  {
    city_cost: :low, 
    start_date: "2015-09-01",
    end_date: "2015-09-01"
  },
  {
    city_cost: :low, 
    start_date: "2015-09-01",
    end_date: "2015-09-01"
  },
  {
    city_cost: :high, 
    start_date: "2015-09-02",
    end_date: "2015-09-02"
  },
  {
    city_cost: :high, 
    start_date: "2015-09-02",
    end_date: "2015-09-03"
  }
]



# questions
# can a day be travel & full? (I think no)

# thoughts
# find start and end dates for set
# iterate through dates, build array of "full" or "travel" elements

class Reimburser  
  
  def calculate(projects) 
    # set_start_date = projects.map{|p| Date.parse(p[:start_date])}.min
    # set_end_date = projects.map{|p| Date.parse(p[:end_date])}.max
    # set_range = (set_start_date..set_end_date)
    projects.each do |project|
      puts Project.new(project).days_hash
    end
  end

end

class Project 
  def initialize(project_hash)
    @start_date = Date.parse(project_hash[:start_date])
    @end_date = Date.parse(project_hash[:end_date])
    @city_cost = project_hash[:city_cost]
  end
  def days_hash
    days_hash = {}
    project_range = (@start_date..@end_date)
    project_range.each_with_index do |d, i|
      date_string = d.to_s
      if i == 0 || i == project_range.to_a.length - 1
        days_hash[date_string] = :travel
      else 
        days_hash[date_string] = :full
      end
    end
    return days_hash
  end
end

puts Reimburser.new.calculate(SET_1)
puts Reimburser.new.calculate(SET_2)
puts Reimburser.new.calculate(SET_3)
puts Reimburser.new.calculate(SET_4)