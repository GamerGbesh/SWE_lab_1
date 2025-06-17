'use client'

export default function Alert({ message }: { message?: string }) {
    if (message) {
        alert(message);
    }
    console.log("here")
    return null;
}