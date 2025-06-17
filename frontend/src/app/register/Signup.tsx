"use client"
import Link from "next/link";
import createUser from "@/app/register/actions";
import {useActionState, useEffect} from "react";
import {redirect} from "next/navigation";

const initialMessage = {success: false, message: ""};

export default function Signup() {
    const [state, formState] = useActionState(createUser, initialMessage);

    useEffect(() => {
        if (state.success) {
            redirect("/");
        }
    }, [state.success]);

    return (
        <div className="max-w-md mx-auto p-4 bg-gray-200 shadow-2xl rounded-lg relative top-30">
            <form action={formState} className="grid place-items-center h-full gap-4">
                <label htmlFor="username">Username</label>
                <input type={"text"} placeholder={"Username"}
                       id={"username"} name={"username"}
                />

                <label htmlFor="email">Email</label>
                <input type="email"
                       placeholder={"Email"}
                       id={"email"} name={"email"}
                />

                <label htmlFor="password">Password</label>
                <input type="password" placeholder={"Password"}
                       id={"password"} name={"password"}
                />

                <label htmlFor="password2">Confirm Password</label>
                <input type="password" placeholder={"Confirm Password"} id={"password2"} name={"password2"}
                />

                <button type={"submit"} className={"bg-blue-900 p-1 rounded-2xl px-6  cursor-pointer"}
                >Sign up</button>

                <p>Already have an account? <Link href={"/login"} className={"text-blue-700"}><span>Login</span></Link></p>
            </form>
            {state.message && (
                <p className={`mt-2 text-sm ${state.success ? 'text-green-600' : 'text-red-600'}`}>
                    {state.message}
                </p>
            )}
        </div>
    );
}