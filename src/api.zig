const types = @import("types.zig");

const std = @import("std");

const patient = types.Patient{ .id = 1, .name = "bob", .age = 20, .gender = types.Gender.male, .address = "123 street", .phone = "1234567890", .email = "a@b.com", .blood_type = types.BloodType.AB, .height = 5.5, .weight = 100, .marital_status = types.MaritalStatus.single, .occupation = "programmer", .allergies = "eggs", .family_history = "family history", .medical_history = "medical history", .current_medication = null };

pub fn main() !void {
    patient.name = "mike";
    std.debug.print("Hello, {s}!\n", .{patient.name});
}
