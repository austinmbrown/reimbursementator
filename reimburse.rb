puts "hello world"

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

class Reimburser do 
  
  def calculate(projects)
    

  end

end

puts Reimburser.new.calculate(SET_1)
puts Reimburser.new.calculate(SET_2)
puts Reimburser.new.calculate(SET_3)
puts Reimburser.new.calculate(SET_4)