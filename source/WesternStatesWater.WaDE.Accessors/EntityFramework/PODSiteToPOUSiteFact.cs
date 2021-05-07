using System;
using System.Collections.Generic;

namespace WesternStatesWater.WaDE.Accessors.EntityFramework
{
    public partial class PODSiteToPOUSiteFact
    {
        public long PODSiteToPOUSiteId { get; set; }
        public long PODSiteId { get; set; }
        public long POUSiteId { get; set; }
        public long StartDateId { get; set; }
        public long EndDateId { get; set; }

        public virtual SitesDim PODSite { get; set;}
        public virtual SitesDim POUSite { get; set; }
        public virtual DateDim StartDateNavigation { get; set; }
        public virtual DateDim EndDateNavigation { get; set; }
    }
}