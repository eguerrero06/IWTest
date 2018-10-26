using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IWTest.Startup))]
namespace IWTest
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
