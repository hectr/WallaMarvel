import Foundation

extension URLSession: NetworkProvider
{
    public func performRequest(
        to endpoint: any Endpoint,
        completion: @escaping @Sendable Completion
    ) -> (any OngoingRequest)?
    {
        do {
            let task = try dataTask(endpoint: endpoint, completion: completion)
            return task
        } catch {
            completion(Result.failure(Failure(error)))
            return nil
        }
    }

    func dataTask(
        endpoint: any Endpoint,
        completion: @escaping @Sendable Completion
    ) throws -> URLSessionDataTask
    {
        let urlRequest = try URLRequest(endpoint)

        let task = dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
                completion(Result.failure(Failure.invalidResponse(response, data)))
            } else if let error {
                completion(Result.failure(Failure(error)))
            } else if let data {
                completion(Result.success(data))
            }
        }

        task.resume()
        return task

    }
}
