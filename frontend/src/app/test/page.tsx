import Link from "next/link";

export default function test(){
    return (
        <div>
            <button><Link href={"/login"}> Click me to move</Link></button>
            <label htmlFor="name">Name</label>
            <input type="text" placeholder={"Name"} id={"name"}/>

        </div>
    )
}