import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published var userLocation: String = ""
    
    init() {
        self.forecast = load("london.json")
    }
    
    // get weather data from the openweather api and add the them to the environment object
    func fetchWeather(lat: Double, lon: Double) async throws {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(API.key)")
        let session = URLSession(configuration: .default)
        
        do {
            //network call to get the data
            let (data, _) = try await session.data(from: url!)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
        } catch {
            throw error
        }
    }
    // loading the initial weather data from the json file
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
