using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(imgs.Startup))]
namespace imgs
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
