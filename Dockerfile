
# Use the official Microsoft .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory inside the container
WORKDIR /app

COPY . .

# Copy the project file to the working directory
COPY aspnet-get-started/aspnet-get-started.csproj .

# Restore the project dependencies
RUN dotnet restore


# Build the application
RUN dotnet build --configuration Release --no-restore

# Publish the application
RUN dotnet publish --configuration Release --no-restore --output /app/publish

# Use the official Microsoft .NET runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the build stage to the final stage
COPY --from=build /app/publish .

# Expose the port the application will listen on
EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "YourProject.dll"]
