# <x=-16, y=15, z=-9>
# <x=-14, y=5, z=4>
# <x=2, y=0, z=6>
# <x=-3, y=18, z=9>
# Io, Europa, Ganymede, and Callisto.

#
#
# sp1 = [-8, -10, 0]
# sp2 = [5, 5, 10]
# sp3 = [2, -7, 3]
# sp4 = [9, -8, -3]

# 8*************************




def find_cyle_on_axis(sp1, sp2, sp3, sp4)

  sv1 = sv2 = sv3 = sv4 = 0
  # sv2 = 0
  # sv3 = 0
  # sv4 = 0

  positions = [sp1, sp2, sp3, sp4]
  vels = [sv1, sv2, sv3, sv4]
  energy = []
  counter = 1
  loop do
    counter+=1
    (0..3).each do |st|
      v_delta = 0
      (0..3).each do |sp|
        if positions[st].to_i > positions[sp].to_i
          v_delta -=1
        elsif positions[st].to_i  < positions[sp].to_i
          v_delta +=1
        end
      end
      vels[st] = vels[st] + v_delta
    end
    (0..3).each do |st|
      positions[st]   = positions[st]  + vels[st]
    end
    if positions[0] == sp1 && positions[1] == sp2 && positions[2] == sp3 && positions[3] == sp4 && sv1 ==0 && sv2 ==0 && sv3 ==0  && sv4 ==0
      break
    end

    # puts counter
  end
  return counter
end

sp1 = -16
sp2 = -14
sp3 = 2
sp4 = -3

x_axis_peiod =  find_cyle_on_axis(sp1, sp2, sp3, sp4)

sp1 = 15
sp2 = 5
sp3 = 0
sp4 = 18

y_axis_peiod =  find_cyle_on_axis(sp1, sp2, sp3, sp4)

sp1 = -9
sp2 = 4
sp3 = 6
sp4 = 9

z_axis_peiod =  find_cyle_on_axis(sp1, sp2, sp3, sp4)

puts "For the answer to puzzle find the least common multipler (lcm) of #{x_axis_peiod}, #{y_axis_peiod}, #{z_axis_peiod} on Internet"
