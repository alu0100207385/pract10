def gcd(u,v)	#gcd = MCD = max. común divisor
  u, v = u.abs, v.abs
  while (v != 0)
    u, v = v, u % v
  end
  u
end

def mcm (a, b)	#mcm = MCM = mín. común múltiplo
 (a*b)/gcd(a,b)
end

# puts "MCD = #{gcd(ARGV[0].to_i,ARGV[1].to_i)}"
# puts "MCM = #{mcm(ARGV[0].to_i,ARGV[1].to_i)}"