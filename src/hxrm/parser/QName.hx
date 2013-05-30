package hxrm.parser;
class QName {
	
	public var namespace : String;
	public var localPart : String;
	
	public static function fromString(s: String) : QName {
		var parts = s.split(":");
		return if (parts.length == 1) {
			new QName("*", parts[0]);
		} else {
			new QName(parts[0], parts[1]);
		}
	}
	
	public function new(namespace : String, localPart : String) {
		this.namespace = namespace == null ? "*" : namespace;
		this.localPart = localPart;
	}

	public function toString() : String {
		return '$namespace:$localPart';
	}
}
