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

#populate distance, colour and opacity arrays
for i in 1:length(x)
    r = (x[i]^2 + y[i]^2 + z[i]^2)^0.5
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

pi_approx = 6*points_in_sphere/points_in_cube

@printf("Pi is approximately: %d",pi_approx);


#visualise results
display(scatter3d(df.x, df.y, df.z, color=df.c, alpha = df.a, legend = false))
