/********************************************************************************************/
// Author: Xuefeng Ding <xuefeng.ding.physics@gmail.com>
// Insitute: 
//   1. Dipartimento di Fisica, Universit\`a degli Studi e INFN, 20133 Milano, Italy
//   2. Gran Sasso Science Institute, L'Aquila, 67100, Italy
// 
// Date: 2016 May 11th
// Description: SmartRec, a reconstruction package bundle
/********************************************************************************************/
#ifndef CLUSTERHIT_H
#define CLUSTERHIT_H
class ClusterHit {
  public:
    ClusterHit(const unsigned int PmtId, const double Charge,const double RawTime,const double Time) : 
      pmtId(PmtId),charge(Charge),rawTime(RawTime),time(Time) {};
    const unsigned int pmtId;
    const double charge;
    const double rawTime;
    const double time;
    bool operator<(const ClusterHit &clusterHitR) const {
      return time<clusterHitR.time;
    }
    static bool compare(const ClusterHit *L,const ClusterHit *R) {
      return (*L)<(*R);
    }
};
#endif
