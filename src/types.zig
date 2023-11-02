const std = @import("std");
const testing = std.testing;
const rand = std.crypto.random;

pub const MaritalStatus = enum {
    single,
    married,
    divorced,
    widowed,
};

pub const Gender = enum {
    male,
    female,
};

pub const BloodType = enum {
    A,
    B,
    AB,
    O,
};

pub const Medication = struct {
    name: []const u8,
    dosage: []const u8,
    frequency: []const u8,
    duration: []const u8,
    instructions: []const u8,
    side_effects: []const u8,

    fn print(self: Medication) void {
        std.debug.print("Name: {s}\n Dosage: {s}\nFrequency: {s}\nDuration: {s}\nInstructions: {s}\nSide effects: {s}\n", .{ self.name, self.dosage, self.frequency, self.duration, self.instructions, self.side_effects });
    }
};

pub const MedicationPtr = *Medication;

pub const MedicationList = std.ArrayList(Medication);

pub const Patient = struct {
    id: u16,
    name: []const u8,
    age: u8,
    gender: Gender,
    address: []const u8,
    phone: []const u8,
    email: []const u8,
    blood_type: BloodType,
    height: f32,
    weight: f32,
    marital_status: MaritalStatus,
    occupation: []const u8,
    allergies: []const u8,
    medical_history: []const u8,
    family_history: []const u8,
    current_medication: ?MedicationList,

    pub fn format(
        patient: Patient,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.writeAll("Patient{\n");
        _ = try writer.print("\tid: {},\n", .{patient.id});
        _ = try writer.print("\tname: {s},\n", .{patient.name});
        _ = try writer.print("\tage: {},\n", .{patient.age});
        _ = try writer.print("\tgender: {},\n", .{patient.gender});
        _ = try writer.print("\taddress: {s},\n", .{patient.address});
        _ = try writer.print("\tphone: {s},\n", .{patient.phone});
        _ = try writer.print("\temail: {s},\n", .{patient.email});
        _ = try writer.print("\tblood_type: {},\n", .{patient.blood_type});
        _ = try writer.print("\theight: {},\n", .{patient.height});
        _ = try writer.print("\tweight: {},\n", .{patient.weight});
        _ = try writer.print("\tmarital_status: {},\n", .{patient.marital_status});
        _ = try writer.print("\toccupation: {s},\n", .{patient.occupation});
        _ = try writer.print("\tallergies: {s},\n", .{patient.allergies});
        _ = try writer.print("\tmedical_history: {s},\n", .{patient.medical_history});
        _ = try writer.print("\tfamily_history: {s},\n", .{patient.family_history});
        _ = try writer.print("\tcurrent_medication: {?},\n", .{patient.current_medication});
        _ = try writer.writeAll("}");
    }
};

pub fn main() !void {
    //const patientid = rand.uintAtMost(u16, std.math.maxInt(u16));
    var rand_impl = std.rand.DefaultPrng.init(0);
    const num = rand_impl.random().uintAtMost(u16, std.math.maxInt(u16));
    const patient: Patient = Patient{
        .id = num,
        .name = "clinton",
        .age = 37,
        .gender = Gender.male,
        .address = "1234 Main St",
        .phone = "1234567890",
        .email = "a@b.com",
        .blood_type = BloodType.AB,
        .height = 5.5,
        .weight = 100,
        .marital_status = MaritalStatus.single,
        .occupation = "Programmer",
        .allergies = "eggs",
        .medical_history = "heart attack",
        .family_history = "diabetes",
        .current_medication = null,
    };

    std.debug.print("{}\n", .{patient});
}

pub const PatientList = std.ArrayList(Patient);

pub const PatientListPtr = *PatientList;

test "simple test" {
    var patient: Patient = Patient{
        .id = rand.uintAtMost(u16, std.math.maxInt(u16)),
        .name = "clinton",
        .age = 37,
        .gender = Gender.male,
        .address = "1234 Main St",
        .phone = "1234567890",
        .email = "a@b.com",
        .blood_type = BloodType.AB,
        .height = 5.5,
        .weight = 100,
        .marital_status = MaritalStatus.single,
        .occupation = "Programmer",
        .allergies = "eggs",
        .medical_history = "heart attack",
        .family_history = "diabetes",
        .current_medication = MedicationList.init(std.testing.allocator),
    };

    try testing.expect(patient.getBloodType() == BloodType.AB);
}
