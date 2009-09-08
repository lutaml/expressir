module Person___module
  attr_accessor :names
  def isValidPerson___module
    return case
      when names == nil : false
      else true
      end
  end
end
module Organization___module
  attr_accessor :name
  def isValidOrganization___module
    return case
      when name == nil : false
      else true
      end
  end
end
module Personorganizationrelationship___module
  attr_accessor :the_person
  attr_accessor :the_organization
  attr_accessor :start_date
  attr_accessor :end_date
  def isValidPersonorganizationrelationship___module
    return case
      when the_person == nil : false
      when the_organization == nil : false
      when start_date == nil : false
      when end_date == nil : false
      else true
      end
  end
end
module Employment___module
  attr_accessor :job_title
  def isValidEmployment___module
    return case
      when job_title == nil : false
      else true
      end
  end
end
