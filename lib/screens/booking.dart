import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kSlotTimes = ['18:30','19:30','20:30'];
bool allowedDay(DateTime d) => {6,7,2,3,4}.contains(d.weekday);

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override State<BookingScreen> createState()=> _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String _visitType = 'كشف جديد';
  final Map<String,int> _capacity = {};

  @override
  void initState(){
    super.initState();
    _selectedDate = _nextAllowed(DateTime.now());
  }

  DateTime _nextAllowed(DateTime from){
    var d = from;
    while(!allowedDay(d)) { d = d.add(const Duration(days: 1)); }
    return DateTime(d.year, d.month, d.day);
  }

  String _slotId(DateTime d, String t){
    final date = DateFormat('yyyyMMdd').format(d);
    final time = t.replaceAll(':','');
    return '${date}_$time';
  }

  int remaining(String slotId){
    final booked = _capacity[slotId] ?? 0;
    return 3 - booked;
  }

  void _book(){
    if(_selectedTime==null) return;
    final sid = _slotId(_selectedDate, _selectedTime!);
    final booked = _capacity[sid] ?? 0;
    if(booked >= 3){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الميعاد مكتمل')));
      return;
    }
    setState(()=> _capacity[sid] = booked + 1);
    final df = DateFormat('y/M/d','ar_EG');
    showDialog(context: context, builder: (_)=> AlertDialog(
      title: const Text('تم حجز موعدك بنجاح'),
      content: Text('التاريخ: ${df.format(_selectedDate)}\nالوقت: $_selectedTime\nالخدمة: $_visitType'),
      actions: [TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('إغلاق'))],
    ));
  }

  @override
  Widget build(BuildContext context){
    final df = DateFormat('EEEE d MMMM','ar_EG');
    return Scaffold(
      appBar: AppBar(title: const Text('حجز المواعيد')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('اختر اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(children: [
            FilledButton.tonal(onPressed: (){
              setState(()=> _selectedDate = _nextAllowed(_selectedDate.add(const Duration(days: -1))));
            }, child: const Text('اليوم السابق')),
            const SizedBox(width: 8),
            Text(df.format(_selectedDate), style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            FilledButton.tonal(onPressed: (){
              setState(()=> _selectedDate = _nextAllowed(_selectedDate.add(const Duration(days: 1))));
            }, child: const Text('اليوم التالي')),
          ]),
          const SizedBox(height: 16),
          const Text('اختر الوقت', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(spacing: 10, children: kSlotTimes.map((t)){
            final isSelected = (t == _selectedTime);
            final sid = _slotId(_selectedDate, t);
            final full = remaining(sid) <= 0;
            final label = full ? '$t (مكتمل)' : '$t (متاح: ${remaining(sid)}/3)';
            return ChoiceChip(
              label: Text(label, textDirection: TextDirection.ltr),
              selected: isSelected,
              onSelected: full ? null : (v)=> setState(()=> _selectedTime = t),
            );
          }).toList()),
          const SizedBox(height: 16),
          const Text('نوع الزيارة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _visitType,
            items: ['كشف جديد','إعادة','جلسة','استشارة'].map((e)=> DropdownMenuItem(value:e, child: Text(e))).toList(),
            onChanged: (v)=> setState(()=> _visitType = v!),
          ),
          const Spacer(),
          SizedBox(width: double.infinity, height: 56,
            child: FilledButton(onPressed: (_selectedTime==null)?null: _book, child: const Text('تأكيد الحجز'))),
        ]),
      ),
    );
  }
}
