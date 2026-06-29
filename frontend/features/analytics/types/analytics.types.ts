/** GlucoseSummaryResponse from GET /glucose/health-data (OpenAPI). Fields optional — the
 *  backend may omit some until enough sensor data exists. Maps are loosely typed upstream. */
export interface GlucoseSummary {
    dataPoints?: number;
    daysAnalyzed?: number;
    average?: number;
    stdDev?: number;
    cv?: number;
    gmi?: number;
    /** Time in range %, time below range %, time above range %. */
    tir?: number;
    tbr?: number;
    tar?: number;
    /** date (YYYY-MM-DD) → time-in-range %. */
    tirByDay?: Record<string, number>;
    hypos?: number;
    severeHypos?: number;
    hypers?: number;
    severeHypers?: number;
    rapidRiseEvents?: number;
    rapidFallEvents?: number;
    /** hour-of-day ("0".."23") → average glucose. */
    dailyAverageByHour?: Record<string, number>;
    /** hour-of-day → percentile map ({p5,p25,p50,p75,p95}). */
    agp?: Record<string, Record<string, number>>;
    estimatedIsf?: number;
    /** Low/High Blood Glucose Index (risk indices). */
    lbgi?: number;
    hbgi?: number;
}
