class Person < ActiveRecord::Base
  def age
    dob = read_attribute(:date_of_birth)
    if dob
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end
  def related_documents
    0
  end
  def media_stories
    0
  end
end
