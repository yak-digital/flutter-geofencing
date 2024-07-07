protocol HandlerProtocol {
    func isRegionMonitoringAvailable() -> Bool
    func startMonitoring(forRegion region: Region)
    func stopMonitoring(forRegion region: Region)
    func getMonitoredRegions() async -> Set<Region>
}
