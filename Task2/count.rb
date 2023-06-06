items = ['bed', 'pillow', 'bed', 'pillow', 'table', 'bed', 'pillow', 'door', 'light', 'minibar', 'light', 'chair', 'chair', 'light', 'light', 'hairdryer', 'soap']

counts = items.each_with_object(Hash.new(0)) { |name, hash| hash[name] += 1 }

counts = counts.sort_by { |k, v| [-v, k] }.to_h

puts count

# tally() method simpler but requires ruby 2.7+

counts = items.tally.sort_by { |k, v| [-v, k] }.to_h
puts counts
