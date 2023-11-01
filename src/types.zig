const std = @import("std");
const testing = std.testing;

pub fn makeStruct(comptime T: type) type {
    return @Type(T);
}

const MaritalStatus = enum {
    single,
    married,
    divorced,
    widowed,
};

const Gender = enum {
    male,
    female,
};

const BloodType = enum {
    A,
    B,
    AB,
    O,
};

const Medication = struct {
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

const MedicationPtr = *Medication;

const MedicationList = std.ArrayList(Medication);

const Patient = struct {
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

    pub fn getAllergies(self: Patient) []const u8 {
        return self.allergies;
    }

    pub fn getFamilyHistory(self: Patient) []const u8 {
        return self.family_history;
    }

    pub fn getMedicalHistory(self: Patient) []const u8 {
        return self.medical_history;
    }

    pub fn getCurrentMedication(self: Patient) MedicationList {
        return self.current_medication;
    }

    pub fn getBloodType(self: Patient) BloodType {
        return self.blood_type;
    }

    pub fn getPatientInfo1(self: Patient) struct {} { //This needs to be fixed. This causes a type error because you are not sure how to return an anonymoust struct
        return struct {
            .name = self.name,
            .age = self.age,
            .phone = self.phone,
            .email = self.email,
            .address = self.address,
        };
    }
};

pub fn getPatientInfo(comptime T: type, patient: T) type {
    return struct {
        .name = patient.name,
        .age = patient.age,
        .phone = patient.phone,
        .email = patient.email,
        .address = patient.address,
    };
}

pub fn main() !void {
    var patient: Patient = Patient{
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

    std.debug.print("Patient name: {s}\n", .{patient.name});
    std.debug.print("Patient blood type: {any}\n", .{patient.getBloodType()});
    std.debug.print("Patient info: {any}\n", .{getPatientInfo(Patient, patient)});
    std.debug.print("Allergies: {s}\n", .{patient.getAllergies()});
    std.debug.print("Family history: {s}\n", .{patient.getFamilyHistory()});
    std.debug.print("Medical history: {s}\n", .{patient.getMedicalHistory()});
}

const PatientList = std.ArrayList(Patient);

const PatientListPtr = *PatientList;

test "simple test" {
    var patient: Patient = Patient{
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
