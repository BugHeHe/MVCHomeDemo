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
    
    public partial class Student
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Student()
        {
            this.StuQueRecords = new HashSet<StuQueRecord>();
        }
    
        public int StudentID { get; set; }
        public string StudentName { get; set; }
        public string Password { get; set; }
        public bool Gender { get; set; }
        public string Phone { get; set; }
        public string CardID { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public System.DateTime Borndate { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public Nullable<int> ClassID { get; set; }
        public Nullable<bool> Shan { get; set; }
    
        public virtual Class Class { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StuQueRecord> StuQueRecords { get; set; }
    }
}
