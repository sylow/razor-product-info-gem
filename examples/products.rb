require_relative 'setup'

all = RazorProductInfo::ProductInfo.all.to_a
ap all
ap RazorProductInfo::ProductInfo.find(all.last.id)
