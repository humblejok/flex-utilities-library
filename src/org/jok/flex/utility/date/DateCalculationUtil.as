package org.jok.flex.utility.date
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	import org.jok.flex.utility.ObjectsUtility;

	public class DateCalculationUtil {
		public function DateCalculationUtil() {
		}
		
		public static function roundToDay(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result.hours = 0;
			result.minutes = 0;
			result.seconds = 0;
			result.milliseconds = 0;
			return result;
		}
		
		public static function getEndOfMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result.date = getDaysInMonth(date.fullYear, date.month);
			return result;
		}
		
		public static function getBeginOfMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result.date = 1;
			return result;
		}
		
		public static function getBeginOfNextMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.month+1>11) {
				result.date = 1;
				result.month = 0;
				result.fullYear += 1;
			} else {
				result.date = 1;
				result.month += 1;
			}
			return result;
		}
		
		public static function getEndOfNextMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.month+1>11) {
				result.date = 31;
				result.month = 0;
				result.fullYear += 1;
			} else {
				if (result.date>28) {
					result.date = 28;
				}
				result.month += 1;
				result.date = getDaysInMonth(result.fullYear,result.month);
			}
			return result;
		}
		
		public static function getBeginOfPreviousMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.month-1<0) {
				result.date = 1;
				result.month = 11;
				result.fullYear -= 1;
			} else {
				result.date = 1;
				result.month -= 1;
			}
			return result;
		}
		
		public static function getEndOfPreviousMonth(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.month-1<0) {
				result.date = 31;
				result.month = 11;
				result.fullYear -= 1;
			} else {
				if (result.date>28) {
					result.date = 28;
				}
				result.month -= 1;
				result.date = getDaysInMonth(result.fullYear,result.month);
			}
			return result;
		}
		
		public static function getEndOfWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==5) {
					// Friday, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,5-result.day);
			} else {
				result = getEndOfWeek(addOrRemoveDays(result,2));
			}
			return result;
		}
		
		public static function getBeginOfWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==1) {
					// Mondaay, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,1-result.day);
			} else {
				result = getBeginOfWeek(addOrRemoveDays(result,-2));
			}
			return result;
		}
		
		public static function getEndOfNextWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result = addOrRemoveDays(result,7);
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==5) {
					// Friday, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,5-result.day);
			} else {
				result = getEndOfWeek(addOrRemoveDays(result,2));
			}
			return result;
		}
		
		public static function getBeginOfNextWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result = addOrRemoveDays(result,7);
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==1) {
					// Mondaay, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,1-result.day);
			} else {
				result = getBeginOfWeek(addOrRemoveDays(result,-2));
			}
			return result;
		}
		
		public static function getEndOfPreviousWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result = addOrRemoveDays(result,-7);
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==5) {
					// Friday, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,5-result.day);
			} else {
				result = getEndOfWeek(addOrRemoveDays(result,2));
			}
			return result;
		}
		
		public static function getBeginOfPreviousWeek(date : Date) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result = addOrRemoveDays(result,-7);
			if (result.day>0 && result.day<6) {
				// Week day
				if (result.day==1) {
					// Mondaay, already a end of week
					return result;
				}
				result = addOrRemoveDays(result,1-result.day);
			} else {
				result = getBeginOfWeek(addOrRemoveDays(result,-2));
			}
			return result;
		}
		
		public static function getDatesDifferenceInDays(from : Date, to : Date) : Number {
			var result : Number = to.time - from.time;
			
			result = ((result / 1000) / 3600) / 24; 
			
			return Math.round(result);
		}
		
		public static function addOrRemoveDays(date : Date, days : Number) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result.date += days;
			return result;
		}
		
		public static function addOrRemoveDaysSkipWeekEnd(date : Date, days : Number) : Date {
			var result : Date = ObjectUtil.clone(date) as Date;
			result.date += days;
			if (result.day == 0) {
				result = addOrRemoveDays(result,1);
			} else if (result.day == 6) {
				result = addOrRemoveDays(result,2);
			}
			return result;
		}
		
		
		public static function getDaysInMonth(year : Number, month : Number) : Number {
			switch(month) {
				case 0: return 31;
				case 1: if (isLeapYear(year)) {
							return 29;
						} else {
							return 28;
						}
				case 2: return 31;
				case 3: return 30;
				case 4: return 31;
				case 5: return 30;
				case 6: return 31;
				case 7: return 31;
				case 8: return 30;
				case 9: return 31;
				case 10: return 30;
				case 11: return 31;
			}
				
			return 31;
		}
		
		public static function isLeapYear(year : Number) : Boolean {
			if ((year%4==00 && year%100!=0) || (year%400== 0)) {
				return true;
			}
			return false;
		}
		
		public static function dateExistsInList(date : Date, datesList : ArrayCollection, dateField : String = "", startingIndex : Number = 0, step : Number = 1) : Boolean {
			for (var i : Number = startingIndex;i>=0;i = i + step) {
				var itemDate : Date = ObjectsUtility.getObjectFieldValue(datesList.getItemAt(i),dateField) as Date; 
				if (date.time==itemDate.time) {
					return true;
				}
			}
			return false;
		}
		
		public static function getEndOfMonthsList(dt : Date, monthsBack : Number) : ArrayCollection {
			var workingDatesList : ArrayCollection = new ArrayCollection();
			dt = DateCalculationUtil.roundToDay(dt);
			var startDate : Date = dt;
			for (var i : Number = 0;i<monthsBack;i++) {
				startDate = DateCalculationUtil.getEndOfPreviousMonth(startDate);
			}
			while (startDate.time<=dt.time) {
				workingDatesList.addItem(startDate);
				startDate = DateCalculationUtil.getEndOfNextMonth(startDate);
			}
			return workingDatesList;
		}
		
	}
}