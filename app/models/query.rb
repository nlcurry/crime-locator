require "date"

class Query < ActiveRecord::Base

  geocoded_by :address
  after_validation :geocode

  def self.count_incidents(incidents)
    results =[]
    count = Hash.new(0)
    current_year = Date.today.year
    current_month = Date.today.month

    incidents.each do |hash|
      next if hash["event_clearance_date"] == nil
      convert_date = Date.parse(hash["event_clearance_date"])
      date_year = convert_date.year
      if date_year == current_year
        results << hash
      end
    end
    results.each { |h| count[h["event_clearance_group"]] += 1 }
    count = Hash[count.map {|k,v| [k,v] }]
  end

  def self.top_five(results)
    sorted_array = results.sort_by { |incident, count| count}.reverse
    pick_five = sorted_array[0,5]
    return pick_five
  end
end

