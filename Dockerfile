FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

COPY TestApi/*.csproj .
RUN dotnet restore 

COPY . .
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .

EXPOSE 8080
ENTRYPOINT [ "dotnet", "TestApi.dll" ]
