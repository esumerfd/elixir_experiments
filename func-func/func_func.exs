choose = fn option1 -> 
  fn option2, decider -> 
    value = "this"
    "Chosen #{value} : #{option1} : #{option2} : #{decider.()}"
  end 
end

value = "don't choose this"
decider = fn -> "decided" end
chooser = choose.("outer_option")
IO.puts chooser.("inner_option", decider)
IO.puts value

