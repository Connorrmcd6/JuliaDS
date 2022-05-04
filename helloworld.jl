# print("Hello World")

#importing libraries
using Plots
using DataFrames
using Distributions
using Printf

#generate random points for 3 coordinates
num_points = 10000
x = rand(Uniform(-1, 1), num_points) 
y = rand(Uniform(-1, 1), num_points)
z = rand(Uniform(-1, 1), num_points)

#create empty arrays to store distance, colour and opacity (alpha)
d = []
c = []
a = []

function distance(x,y,z)
    d = (x^2 + y^2 + z^2)^0.5
    return d
end

#populate distance, colour and opacity arrays
for i in 1:length(x)
    r = distance(x[i],y[i],z[i])
    push!(d, r)
    if r <= 1
        push!(c, "red")
        push!(a, 1)
    else
        push!(c, "blue")
        push!(a, 0.4)
    end

end 

#store results in a dataframe
df = DataFrame(x = vec(x), 
               y = vec(y),
               z = vec(z),
               d = vec(d),
               c = vec(c),
               a = vec(a)
               )

#=
approximate pi as follows: 
- volume of a sphere = 4/3 * π * r^3
- volume of a cube = (2r)^3

∴ (sphere volume)/(cube volume) = 4π/24
∴ 6(sphere volume)/(cube volume) = π

with this logic:
    
    6(number of red points)/4(number of blue points) ≈ π
=#

points_in_sphere = length(filter(x->x<1,d))
points_in_cube = num_points

approximation = 6*(points_in_sphere)/(points_in_cube)
print("Pi is approximately: ",approximation);

t = []
for i in d
    if i <= 1
        push!(t, 1)
    else
        push!(t, 0)
    end
end


pt = []
xpt = []
cnt = 0
v = 0

for i in t
    global v += i
    global cnt += 1
    v2 = 6*v/cnt
    push!(pt, v2)
    push!(xpt, cnt)
end


#visualise results
display(scatter3d(df.x, df.y, df.z, color=df.c, alpha = df.a, legend = false, title = "Random Points Visualisation"))

display(plot(xpt, pt, legend = false, title = "Pi Approximation", xlabel = "Number of Points", ylabel="Approximate Value of Pi"))