using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using imgs.Models;
using System.Data.SqlClient;

namespace imgs.DAL
{
    public class dataAccess : DbContext
    {
        public IEnumerable<image> AddImage(int procId, image Model)
        {
            var param = new SqlParameter[]
            {
                new SqlParameter {ParameterName="@id",Value=Model.id==null?0:Model.id },
                new SqlParameter {ParameterName="@name",Value=Model.name??string.Empty },
                new SqlParameter{ParameterName = "@Imagepath",Value=Model.Imagepath??string.Empty},
                 new SqlParameter{ParameterName = "@ProcId",Value=procId},


            };
            var sqlquery = @"Sp_imgs @id,@name,@imagePath,@procId";
            return this.Database.SqlQuery<image>(sqlquery, param);
        }
    }
}