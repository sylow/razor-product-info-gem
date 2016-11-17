module RazorProductInfo

  class BaseModel
    include Her::Model
    use_api RazorProductInfo::Api
  end

end
