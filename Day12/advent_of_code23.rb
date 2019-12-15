# <x=-16, y=15, z=-9>
# <x=-14, y=5, z=4>
# <x=2, y=0, z=6>
# <x=-3, y=18, z=9>
# Io, Europa, Ganymede, and Callisto.

sp1 = [-16, 15, -9]
sp2 = [-14, 5, 4]
sp3 = [2, 0, 6]
sp4 = [-3, 18, 9]

sv1 = [0, 0, 0]
sv2 = [0, 0, 0]
sv3 = [0, 0, 0]
sv4 = [0, 0, 0]

positions = [sp1, sp2, sp3, sp4]
vels = [sv1, sv2, sv3, sv4]

energy = []

t_energy = 0
(0..999).each do |s|
  (0..3).each do |st|
    (0..2).each do |co|
      v_delta = 0
      (0..3).each do |sp|
        if positions[st][co].to_i > positions[sp][co].to_i
          v_delta -=1
        elsif positions[st][co].to_i  < positions[sp][co].to_i
          v_delta +=1
        end
      end
      vels[st][co] = vels[st][co] + v_delta
    end
  end
  (0..3).each do |st|
    (0..2).each do |co|
      positions[st][co]  = positions[st][co] + vels[st][co]
    end
  end
  (0..3).each do |st|
    pot = 0
    kin  = 0
    en = 0
    (0..2).each do |co|
      pot = pot + positions[st][co].abs
      kin = kin + vels[st][co].abs
    end
    en = pot*kin
    energy[st] = en
  end

  total_energy = 0
  (0..3).each do |e|
    total_energy = total_energy + energy[e]
  end
  # puts "total_e  #{total_energy}"
  t_energy = total_energy
end
puts t_energy
