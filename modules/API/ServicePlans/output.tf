output "ServicePlanKV" {
  value = {
    for sp in azurerm_service_plan.ServicePlansRG : sp.name => { id = sp.id, name = sp.name }
  }
}
