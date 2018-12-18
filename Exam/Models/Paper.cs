//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace Exam.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Paper
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Paper()
        {
            this.PaperDetails = new HashSet<PaperDetail>();
            this.StuQueRecords = new HashSet<StuQueRecord>();
        }
    
        public int PaperID { get; set; }
        public string PaperName { get; set; }
        public int GradeID { get; set; }
        public int typeID { get; set; }
        public int Duration { get; set; }
        public bool IsOpen { get; set; }
        public string ClassList { get; set; }
        public int RuleID { get; set; }
        public int QuestionCount { get; set; }
        public System.DateTime CreateTime { get; set; }
        public int CreatorID { get; set; }
    
        public virtual Grade Grade { get; set; }
        public virtual Teacher Teacher { get; set; }
        public virtual PaperRule PaperRule { get; set; }
        public virtual PaperType PaperType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PaperDetail> PaperDetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StuQueRecord> StuQueRecords { get; set; }
    }
}
