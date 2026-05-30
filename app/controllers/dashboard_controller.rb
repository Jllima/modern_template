class DashboardController < ApplicationController
  def index
    # We can pass dummy data to emulate actual metrics and lists
    @stats = [
      { label: "Active Users", value: "1,248", change: "+12.5%", trend: "up", bg: "bg-emerald-50 text-emerald-700 border-emerald-100" },
      { label: "Revenue", value: "$45,231.89", change: "+8.2%", trend: "up", bg: "bg-blue-50 text-blue-700 border-blue-100" },
      { label: "Bounce Rate", value: "24.15%", change: "-2.1%", trend: "down", bg: "bg-amber-50 text-amber-700 border-amber-100" }
    ]

    @users = [
      { id: 1, name: "Lucas Silva", email: "lucas@exemplo.com", role: "Administrator", status: "Active", badge: "bg-emerald-100 text-emerald-800" },
      { id: 2, name: "Maria Santos", email: "maria@exemplo.com", role: "Editor", status: "Active", badge: "bg-emerald-100 text-emerald-800" },
      { id: 3, name: "Pedro Costa", email: "pedro@exemplo.com", role: "Contributor", status: "Pending", badge: "bg-amber-100 text-amber-800" },
      { id: 4, name: "Ana Souza", email: "ana@exemplo.com", role: "Viewer", status: "Inactive", badge: "bg-slate-100 text-slate-800" }
    ]
  end
end
