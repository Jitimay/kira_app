import 'package:flutter/material.dart';
import 'package:kira/models/invoice.dart';
import 'package:kira/services/invoice_service.dart';

class InvoiceProvider with ChangeNotifier {
  final InvoiceService _invoiceService = InvoiceService();
  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  void updateInvoice(Invoice updatedInvoice) {
    final index = _invoices.indexWhere((invoice) => invoice.id == updatedInvoice.id);
    if (index != -1) {
      _invoices[index] = updatedInvoice;
      notifyListeners();
    }
  }

  void deleteInvoice(String id) {
    _invoices.removeWhere((invoice) => invoice.id == id);
    notifyListeners();
  }
}
