# Implement Rails 4's try method - returns nil instead of NoMethodError when object exists but doesn't respond to given method
class Object
  alias_method :try!, :try

  def try(*a, &b)
    if !respond_to?(*a)
      nil
    else
      try!(*a, &b)
    end
  end
end
